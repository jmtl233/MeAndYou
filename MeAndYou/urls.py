from django.urls import path
from diary import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.home, name='home'),
    path('add/', views.add_diary, name='add_diary'),
    path('delete/<int:diary_id>/', views.delete_diary, name='delete_diary'),  # 删除日记
    path('diary/<int:diary_id>/', views.diary_detail, name='diary_detail'),
    path('comment/delete/<int:comment_id>/', views.delete_comment, name='delete_comment'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
