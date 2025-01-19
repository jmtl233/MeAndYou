# diary/forms.py
from django import forms
from .models import Diary
from .models import Comment

class DiaryForm(forms.ModelForm):
    class Meta:
        model = Diary
        fields = ['title', 'content']  # 根据需要选择需要的字段




class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['content']


