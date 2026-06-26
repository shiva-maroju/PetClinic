FROM maven:3.9.7-eclipse-temurin-17 AS build
RUN git clone https://github.com/shiva-maroju/PetClinic.git
RUN cd PetClinic && mvn clean package

FROM eclipse-temurin:17-alpine AS run
LABEL AUTHOR="shivamaroju"
LABEL PROJECT="PetClinic"
RUN mkdir /spc && chown nobody /spc
USER nobody
WORKDIR /spc
COPY --from=build --chown=nobody:nobody /PetClinic/target/spring-petclinic-4.0.0-SNAPSHOT.jar /spc/petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "petclinic.jar"]

