---
title: "Projects"
draft: false
comments: false
showtoc: true
tocopen: true
---

## :bulb: Contributions to open source
I want to be useful to the community and suggest improvements for tools I use myself :blush:.
  
### kafka-python 

One project had the need to get rid of Kafka's consumer rebalances in order to provide constant reading from topics. 
However, none of the popular client libraries (**kafka-python**, **confluent-kafka**, **pykafka**) offered this 
functionality, despite the fact that it was already implemented in the 2.3.0 version of the broker. I first implemented 
this feature by overriding **KafkaConsumer** in the project repository and then opened the 
[Pull request](https://github.com/dpkp/kafka-python/pull/2333). Unfortunately, the project is almost abandoned now.
  
***
  
### Django extensions 

When I worked on a few new features, I often came across a situation where I had to switch between branches, 
roll back migrations of one branch, and apply migrations of another. As long as you work in the same Django app, 
no problems arise. But when migrations involve multiple Django applications, rolling back of each application
becomes a frustrating chore. 
  
I wrote a [Django command](https://github.com/django-extensions/django-extensions/pull/1676) that captures 
a state of migrations on the current branch to a file and makes it easy to switch between branches.
***

### Jaeger client 
  
Jaeger is a great code tracing tool. But one day I needed more flexible customization, 
which the configuration of the client library did not allow. I suggested applying 
[dependency injection](https://github.com/jaegertracing/jaeger-client-python/issues/344) to the config class.
***

## :open_file_folder: My projects 

### [Relatives](https://relatives.tk) - the service for building family trees 
  
I have long wanted to build a family tree, but I could not find suitable free tools for this, and those that were 
found did not meet my requirements. So I decided to reinvent the wheel. And at the same time to use some 
modern technologies for this, to get acquainted them better. That's why I chose **FastAPI** with asynchronous **ORM**, 
although they are absolutely irrelevant, and **Django** could fit much better.  
  
`FastAPI` `Ormar` `Asyncio`
***
  
### Sitemap generation library

The library is published at [PyPI](https://pypi.org/project/dynamic-sitemap/),
and the documentation is hosted at [readthedocs](https://dynamic-sitemap.readthedocs.io/en/latest/#installation).
  
Initially, I only needed to add a sitemap to my [Flask blog project](#блог-на-flask). However, after I did not find 
a more or less attractive alternative, I decided to write my library, and at the same time learn how to publish it 
to the python package index. Then I decided to use it also to study various tools, for example, 
[Sphinx](https://www.sphinx-doc.org/en/master/).
  
`Python` `Sphinx`
***

### Flask blog

[The blog](https://github.com/KazakovDenis/flask-blog)  was the first project which helped me in learning Flask and 
infrastructure to deploy and host Python apps. I still update it occasionally. For about a year and a half, this site 
worked using this particular engine.

I deployed the blog to a bare metal server on [VDSina.ru](https://vdsina.ru/?partner=vgwnu9nntn) and launched CI / CD 
using [Travis CI](https://github.com/KazakovDenis/flask-blog/blob/master/.travis.yml) and Docker hub webhooks. 
In principle, having changed the necessary keys, it can be quickly deployed to an external server even now.
  
`Flask` `SQLAlchemy` `Docker` `Nginx` `Travis CI`
***

## :school_satchel: Test tasks 

Merely I left a couple of tasks here, which turned out well.

### The backend for content storage

In [this task](https://github.com/KazakovDenis/drf-content-storage#content-storage), it was necessary to write an API 
with which it would be possible to get a list of pages with content and the video, audio, or text content itself.
  
`Django REST framework` `Docker`
***
  
### The backend for survey service

The task was to develop [an API](https://github.com/KazakovDenis/drf-survey-service) with which system administrators 
can log in, create, modify, delete surveys, and users can get a list of active, completed surveys and take part in them. 
[Here](https://github.com/KazakovDenis/drf-survey-service/blob/main/survey_service/api/v1/docs/docs.md) I have 
carefully described its user documentation.
  
`Django REST framework` `Docker`
***
