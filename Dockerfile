FROM python:3.8
CMD ["python", "-m", "pip", "install" ,"–upgrade" ,"pip"]
COPY . /
CMD ["python", "install" ,"-r" ,"requirements.txt"]
ENTRYPOINT ["python" ,"run.py"]
