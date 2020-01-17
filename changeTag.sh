#!/bin/bash
sed "s/tagVersion/$1/g" bulletinboard.yaml > bulletinboarddeploy.yaml
