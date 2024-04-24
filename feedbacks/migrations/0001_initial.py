# Generated by Django 5.0.4 on 2024-04-23 18:33

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('User_profile', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='feedback',
            fields=[
                ('feedback_id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='feedback id ')),
                ('title', models.CharField(max_length=20, verbose_name='title')),
                ('content', models.CharField(max_length=2000)),
                ('date_submitted', models.DateTimeField(auto_now=True)),
                ('student_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='User_profile.student', verbose_name='student id')),
            ],
        ),
    ]
