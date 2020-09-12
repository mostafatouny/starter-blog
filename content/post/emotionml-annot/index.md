---
title: "Emotion Annotation: W3C's EmotionML"
subtitle: In which data format would machines interpret emotions?
summary: In which data format would machines interpret emotions?
#authors:
#- admin
tags: []
categories: []
date: "2019-11-23T00:10:00Z"
#lastMod: "2019-09-05T00:00:00Z"
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: "W3C's Official Page"
  focal_point: ""

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references 
#   `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

### Introduction
Considering the hype of data-science, Most probably, you have heard of analyzing users to adapt the content shown to them. Such analysis is closely related to human emotions as decision makers wish to know what users tend to and get influenced by. For example, Advertisments served by Google are adapted to what is expected to attract you. Some video-games assess your skill and accordingly tune the difficulty so that you neither feel frustrated of inaccessible challenge nor bored of trivial walkthrough. Check out Square Enix's GDC slides, [Changing the Game: Measuring and Influencing Player Emotions Through Meta AI](https://www.gdcvault.com/play/1026416/Changing-the-Game-Measuring-and). Regardless of the application, In case we wished machines to communicate or process humans emotions, Then the data associated with emotions must be formed in some representation. Usually, The models which describe emotions are developed in psychology and cognitive science literature. However, I shall use these models in describing computer data related to emotions. This is not the first time cognitive science and computer science go hand in hand. On the contrary, The interplay of both of them is deeply rooted. In fact, One of the main pillars of the revolution of cognitive science is psychological mechanisms being modeled as AI models!

___

### Contents
- [Introduction](#introduction)
- [Prototype: Emotion Annotation](#prototype-emotion-annotation)
- [Future and Potential](#future-and-potential)
- [Summary](#summary)

___

### Prototype: Emotion Annotation
I shall now present a basic prototype. It is based on [*W3C*'s Emotion Markup Language (2014)](https://www.w3.org/TR/emotionml/), so check it out in order to grasp the scene behind my prototype. In addition, You might wish to consult [Rizky Winanda's article](https://www.gamasutra.com/blogs/RizkyWinanda/20140513/217622/A_Better_Narrative_using_OCC_Emotional_Model.php), as the OCC model is the most successfull model in computer science for simulating emotions in AI agents. Winanda's article is going to familiarize you with emotion modelling. 

My prototype is a very primtive proof of concept and has nothing to do with fancy modelling or content generation. It is basically a manual-entry of emotion-based annotation. These annotations are linked to entities via unique IDs. Each entity is described by filling values of an emotion-based model. IDs and their associated values are stored in an XML file. Check out the [github repo](https://github.com/mostafatouny/Emotion-Annotation-W3C-EmotionML) for more details.

___

### Future and Potential
It is commonly said that in the same way the twentieth century had been an astonishing strike for physicists —by quantum mechanics, The twenty-first century is going to be for cognitive-scientists. Nonetheless, I had never heard of any notable work which integrates cognitive mechanisms into data-science. Seemingly, Stakeholders would wait for some time untill cognition see the light in their data-driven business models.

On the other hand, Researchers have a huge uncharted ground to explore as the disciple of affective computing is still in its infancy. While physics enjoyed brights like Issac Newton, James Clark Maxwell and Einstein, The scene in cognitive or affective science saw no similar accomplishments. I personally believe the next step forward in understanding human emotions shall not be by cognitive-science community but data scientists who aspire to model users' emotions, explain how some patterns contribute to users engagement, and even adapt emotion-based content for them. I partially attribute my stance due to the ever increasing demand of monetization via data-driven business models. Currently, Industries measure users engagement by pure statistical metrics like the average session time of using some application. Notably, Cognitive and emotion sciences theories are largely based upon statistics as well. I find it so curious for an engineering disciple to influence a scientific one, Computer programs acting as precise models for psychologists! You should know where to look now for such intriguing investigations.

___

### Summary
Today's machines are hoped to effictively process and communicate emotions. The industrial impact of modelling users and generate adapted content is mind-boggling. While the current state of the art relies upon pure statistical metrics for measuring users engagement, Further developments in cognition or affection are expected to see the light in data-science. The interplay of computing and affection is going to impact affection researchers alongside engineers and stakeholders.
