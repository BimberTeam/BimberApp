import os
import sys
import subprocess

from os import listdir, getcwd
from os.path import isfile, join

models_path = "models"

files = [f for f in listdir(models_path) if isfile(join(models_path, f))]

dest_path = "../lib/models/"


for file in files:
    print(f"Running {file} generation...")
    run = f"python3 generation/generate_model.py -i {join(models_path, file)} --discover-output true"
    subprocess.run(run, shell=True)

dest_path = os.path.abspath(dest_path)
os.system("flutter format *.dart")

os.system(f"mv *.dart {dest_path}")
