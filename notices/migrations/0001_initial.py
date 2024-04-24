# Generated by Django 5.0.4 on 2024-04-23 17:09

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Notices',
            fields=[
                ('notice_id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='notice id')),
                ('title', models.CharField(max_length=20, verbose_name='title')),
                ('content', models.CharField(max_length=3000, verbose_name='content')),
                ('image', models.ImageField(max_length=100000, upload_to='notice_files', verbose_name='notice files')),
            ],
        ),
    ]
