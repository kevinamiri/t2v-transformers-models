# transformers inference (for Weaviate)

This is the the inference container which is used by the Weaviate
`text2vec-transformers` module. You can download it directly from Dockerhub
using one of the pre-built images or built your own (as outlined below).

It is built in a way to support any PyTorch or Tensorflow transformers model,
either from the Huggingface Model Hub or from your disk.

This makes this an easy way to deploy your Weaviate-optimized transformers
NLP inference model to production using Docker or Kubernetes.

## Documentation

### Custom build with any huggingface model

You can build a docker image which supports any model from the huggingface
model hub with a two-line Dockerfile.

In the following example, we are going to build a custom image for the
`distilroberta-base` model.

Create a new `Dockerfile` (you do not need to clone this repository, any folder
on your machine is fine), we will name it `distilrobert.Dockerfile`. Add the
following lines to it:

```
FROM semitechnologies/transformers-inference:custom
RUN MODEL_NAME=distilroberta-base ./download.py
```

Now you just need to build and tag your Dockerfile, we will tag it as
`distilroberta-inference`:

```
docker build -f distilroberta.Dockerfile -t distilroberta-inference .
```

That's it! You can now push your image to your favorite registry or reference
it locally in your Weaviate `docker-compose.yaml` using the docker tag
`distilroberta-inference`.

### Custom build with a private / local model

You can build a docker image which supports any model which is compatible with
Huggingface's `AutoModel` and `AutoTokenzier`.

In the following example, we are going to build a custom image for a non-public
model which we have locally stored at `./ie`.

Create a new `Dockerfile` (you do not need to clone this repository, any folder
on your machine is fine), we will name it `ie.Dockerfile`. Add the
following lines to it:

```
FROM semitechnologies/transformers-inference:custom
COPY ./ie /app/models/model
```

The above will make sure that your model end ups in the image at
`/app/models/model`. This path is important, so that the application can find the
model.

Now you just need to build and tag your Dockerfile, we will tag it as
`ie-inference`:

```
docker build -f ie.Dockerfile -t ie-inference .
```

That's it! You can now push your image to your favorite registry or reference
it locally in your Weaviate `docker-compose.yaml` using the docker tag
`ie-inference`.
