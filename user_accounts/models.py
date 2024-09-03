import uuid

from django.conf import settings
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, UserManager
from django.db import models


class CustomUserManage(UserManager):
    def _create_user(self, name, email, password, **extra_fields):
        if not email:
            raise ValueError("Please enter a valid email")
        
        email = self.normalize_email(email)