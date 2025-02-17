FROM python:3.8

RUN useradd --create-home userapi
WORKDIR /departmentsProject

RUN pip install -U pipenv
COPY Pipfile .
COPY Pipfile.lock .
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy --system
COPY ./ .
RUN chown -R userapi:userapi ./
USER userapi

EXPOSE 5000
CMD gunicorn --bind 0.0.0.0:$PORT wsgi:app