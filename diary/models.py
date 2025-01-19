
import os

from django.db import models

class Diary(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    image = models.ImageField(upload_to='diary_images/', blank=True, null=True)  # 存储在 media/diary_images/


    def __str__(self):
        return self.title

    def delete(self, *args, **kwargs):
        # 删除图片文件
        if self.image:
            image_path = self.image.path
            if os.path.isfile(image_path):
                os.remove(image_path)
        super().delete(*args, **kwargs)


class Comment(models.Model):
    diary = models.ForeignKey('Diary', on_delete=models.CASCADE, related_name='comments')
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'评论：{self.content[:20]}'
        return f'评论：{self.content[:20]}'

