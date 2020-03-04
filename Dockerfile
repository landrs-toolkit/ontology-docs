FROM java:openjdk-8-alpine AS builder
ADD https://github.com/dgarijo/Widoco/releases/download/v1.4.13/widoco-1.4.13-jar-with-dependencies.jar /usr/bin/widoco.jar
ADD https://raw.githubusercontent.com/landrs-toolkit/LANDRS-o/master/ontology.ttl /app/ontology.ttl
RUN java -jar /usr/bin/widoco.jar -ontFile /app/ontology.ttl -outFolder /output -oops -lang en -includeImportedOntologies -rewriteAll -getOntologyMetadata -includeImportedOntologies -webVowl -licensius -displayDirectImportsOnly -uniteSections \
    && mv /output/doc/index-en.html /output/doc/index.html


FROM nginx:mainline-alpine
COPY --from=builder /output/doc/ /usr/share/nginx/html/