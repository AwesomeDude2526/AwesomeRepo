#!/bin/bash

DATE=$(date +"%F")
TIME=$(date +"%T")

tar -czvf /tmp/messages.$DATE.$TIME.tar.gz /var/log/messages
