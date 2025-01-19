from django.shortcuts import render, redirect, get_object_or_404
from .models import Diary, Comment
from .forms import DiaryForm
from django.contrib import messages
from .forms import CommentForm

def home(request):
    diaries = Diary.objects.all()  # 获取所有日记
    return render(request, 'home.html', {
        'title': '欢迎来到柿饼好甜~的日记本哦~', 'subtitle': '记录生活的点滴', 'diaries': diaries, 'year': 2025
    }
                  )


# def diary_list(request):
#     diaries = Diary.objects.all()  # 获取所有日记
#     return render(request, 'diary_list.html', {'diaries': diaries})


def add_diary(request):
    if request.method == 'POST':
        # 包括 request.FILES 以处理文件上传
        form = DiaryForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()  # 保存表单数据，包括上传的文件
            messages.success(request, '日记提交成功！')
            return redirect('home')  # 提交成功后重定向到首页
    else:
        form = DiaryForm()  # 如果是 GET 请求，显示空表单

    # 渲染模板并传递表单上下文
    return render(request, 'add_diary.html', {'form': form})


def delete_diary(request, diary_id):
    diary = get_object_or_404(Diary, id=diary_id)
    if request.method == 'POST':
        diary.delete()
        messages.success(request, "日记已删除")
        return redirect('home')




def diary_detail(request, diary_id):
    diary = Diary.objects.get(id=diary_id)
    comments = diary.comments.all()

    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            # 保存评论
            comment = form.save(commit=False)
            comment.diary = diary  # 关联当前日记
            comment.save()
            return redirect('diary_detail', diary_id=diary.id)  # 提交后刷新页面
    else:
        form = CommentForm()

    return render(request, 'diary_detail.html', {
        'diary': diary,
        'comments': comments,
        'form': form,
    })


def delete_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id)
    # 确保是作者删除评论（可以根据需要加入权限检查）
    if request.method == 'POST':
        comment.delete()
    return redirect('diary_detail', diary_id=comment.diary.id)


def delete_diary(request, diary_id):
    diary = get_object_or_404(Diary, id=diary_id)
    diary.delete()
    return redirect('home')



