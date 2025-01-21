from django.shortcuts import render, redirect, get_object_or_404
from .models import Diary, Comment
from .forms import DiaryForm, CommentForm
from django.contrib import messages
from django.core.paginator import Paginator


def home(request):
    # 获取所有日记并按创建时间倒序排列
    diary_list = Diary.objects.all().order_by('-created_at')

    # 分页，每页 5 个日记
    paginator = Paginator(diary_list, 5)  # 每页显示 5 条记录
    page_number = request.GET.get('page')  # 获取当前页码
    diaries = paginator.get_page(page_number)  # 获取对应页的记录

    return render(request, 'home.html', {
        'title': '欢迎来到柿饼好甜~的日记本哦~',
        'subtitle': '记录生活的点滴',
        'diaries': diaries,  # 将分页后的对象传递给模板
        'year': 2025,
    })


def add_diary(request):
    if request.method == 'POST':
        form = DiaryForm(request.POST, request.FILES)  # 包括文件上传
        if form.is_valid():
            form.save()
            messages.success(request, '日记提交成功！')
            return redirect('home')
    else:
        form = DiaryForm()

    return render(request, 'add_diary.html', {'form': form})


def delete_diary(request, diary_id):
    diary = get_object_or_404(Diary, id=diary_id)
    if request.method == 'POST':
        diary.delete()
        messages.success(request, "日记已删除")
    return redirect('home')


def diary_detail(request, diary_id):
    diary = get_object_or_404(Diary, id=diary_id)  # 获取指定日记
    comments = diary.comments.all().order_by('-created_at')  # 按时间排序评论

    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.diary = diary  # 关联当前日记
            comment.save()
            messages.success(request, '评论已添加！')
            return redirect('diary_detail', diary_id=diary.id)
    else:
        form = CommentForm()

    return render(request, 'diary_detail.html', {
        'diary': diary,
        'comments': comments,
        'form': form,
    })


def delete_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id)
    if request.method == 'POST':
        comment.delete()
        messages.success(request, '评论已删除')
    return redirect('diary_detail', diary_id=comment.diary.id)
