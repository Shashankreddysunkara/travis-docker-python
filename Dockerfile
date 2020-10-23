FROM python:3.7
ENV PYTHONUNBUFFERED 1
#Running Cron
RUN apt-get update && apt-get install -y cron
#RUN touch /var/log/crontab.log \
#&& echo "* * * * *  /code/manage.py index_actordevices >> /var/log/crontab.log 2>&1" >> /etc/crontab \
#&& echo "* * * * *  /code/manage.py index_deviceprofile >> /var/log/crontab.log 2>&1" >> /etc/crontab \
#&& crontab /etc/crontab
## App setup
ADD . /code
WORKDIR /code
# Requirements installation
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python", "-c", "print(12345)"]
