# Pull the base image with python 3.11 as a runtime for your Lambda
# Tensorflow 2.15를 쓰기 위한 Python 3.11
FROM public.ecr.aws/lambda/python:3.11

# Copy the earlier created requirements.txt file to the container
COPY requirements.txt ./

RUN yum update -y
RUN yum install -y mesa-libGL

# Install the python requirements from requirements.txt
RUN python3 -m pip config set global.break-system-packages true
RUN python3.11 -m pip install -r requirements.txt

# Copy the earlier created app.py file to the container
COPY app.py ./
COPY cnn_model.py ./
COPY module_import_example.py ./
COPY personal_color.py ./

# Set the CMD to your handler
CMD ["app.lambda_handler"]