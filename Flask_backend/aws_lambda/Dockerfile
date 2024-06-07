# Pull the base image with python 3.12 as a runtime for your Lambda
FROM public.ecr.aws/lambda/python:3.12

# Copy the earlier created requirements.txt file to the container
COPY requirements.txt ./

RUN dnf update -y
RUN dnf install -y mesa-libGL

# Install the python requirements from requirements.txt
RUN python3 -m pip config set global.break-system-packages true
RUN python3.12 -m pip install -r requirements.txt

# Copy the earlier created app.py file to the container
COPY app.py ./
COPY cnn_model.py ./
COPY module_import_example.py ./

# Set the CMD to your handler
CMD ["app.lambda_handler"]