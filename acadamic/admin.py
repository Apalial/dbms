from django.contrib import admin
from .models import Courses
from .models import Subjects ,sessions

# Register your models here.

class AccountCourses(admin.ModelAdmin):
    list_display = ('course_id','course_name')
    search_fields = ['course_name']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

class AccountSubject(admin.ModelAdmin):
    list_display = ('subject_id','subject_name','course_id')
    search_fields = ['subject_name']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

class AccountSession(admin.ModelAdmin):
    list_display = ('session_id','start_date','end_date')
    search_fields = ['start_date','end_date']
    filter_horizontal = ()
    list_filter=()
    fieldsets =()

admin.site.register(Courses , AccountCourses)
admin.site.register(Subjects , AccountSubject)
admin.site.register(sessions , AccountSession)