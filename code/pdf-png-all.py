#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 20 03:43:55 2018

@author: omusubi
"""

import os
from pdf2image import convert_from_path

path = "/Users/omusubi/Downloads/PDF-PNG/imaaru"
path_list = os.listdir(path)
path_list.pop(70)
print(path_list)
i = 0
for path_last in path_list:
    img_paths = convert_from_path("/Users/omusubi/Downloads/PDF-PNG/imaaru/{}".format(path_last))
    for img_path in img_paths:
        img_path.save('ima{}.png'.format(i), 'png')
        i += 1