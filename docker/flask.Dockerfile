FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN pip install flask
CMD ["python", "flask_app.py"]
