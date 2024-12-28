FROM python
WORKDIR /src
COPY . .
RUN pip3 install flask
EXPOSE 4000
CMD python3 server.py

