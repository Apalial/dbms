# Generated by Django 5.0.4 on 2024-04-23 17:15

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('notices', '0002_notices_date_posted'),
    ]

    operations = [
        migrations.AlterField(
            model_name='notices',
            name='date_posted',
            field=models.DateTimeField(auto_created=True, default=datetime.datetime(2024, 4, 23, 22, 45, 29, 969022)),
        ),
    ]
