---
title: "Camel case to snake case serializer in Django REST framework"
tags: ["Django", "DRF"]
date: 2021-10-01T20:00:00+03:00
draft: false
---

How to convert a dict with camel case keys into a dict with snake case keys?  
Check out below  

```python
from django.utils.functional import cached_property
from rest_framework import serializers


class KeyMappingSerializerMixin:
    Meta: type

    @cached_property
    def fields(self):
        # noinspection PyUnresolvedReferences
        fields = super().fields
        key_map = getattr(self.Meta, 'key_map', {})
        for target, source in key_map.items():
            if target != source:
                fields[target].bind(field_name=source, parent=self)
        return fields

    
 class ExternalServiceCallbackSerializer(KeyMappingSerializerMixin, serializers.ModelSerializer):
    class Meta:
        model = ExternalServiceCallback
        fields = ('timestamp', 'service_name', 'user_data')
        key_map = {
            'timestamp': 'createdAt',
            'service_name': 'service',
            'user_data': 'userData',
        }
```
