FROM java:jre-alpine

RUN apk update
RUN apk add ca-certificates openssl

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-02-27.zip

RUN unzip stanford-corenlp-full-2018-02-27.zip && \
	rm stanford-corenlp-full-2018-02-27.zip

WORKDIR stanford-corenlp-full-2018-02-27

RUN wget http://nlp.stanford.edu/software/stanford-chinese-corenlp-2018-02-27-models.jar && \
		wget http://nlp.stanford.edu/software/stanford-english-corenlp-2018-02-27-models.jar && \
		wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-2018-02-27-models.jar


RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000

EXPOSE $PORT

CMD java -cp "*" -mx8g edu.stanford.nlp.pipeline.StanfordCoreNLPServer --serverProperties StanfordCoreNLP-chinese.properties -port 9000
