from rest_framework import serializers

from .models import Properties

class PropertiesListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Properties
        fields = [
            'id',
            'title',
            'price_per_night',
            'image_url'
        ]