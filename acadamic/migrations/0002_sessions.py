# Generated by Django 5.0.4 on 2024-04-23 18:38

import datetime
import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('acadamic', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='sessions',
            fields=[
                ('session_id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='session id')),
                ('start_date', models.DateField(default=datetime.date.today, verbose_name='from')),
                ('end_date', models.DateField(default=datetime.date.today, verbose_name='to')),
                ('course_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='acadamic.courses')),
            ],
        ),
    ]
