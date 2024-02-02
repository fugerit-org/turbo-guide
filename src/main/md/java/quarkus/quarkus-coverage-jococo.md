# quarkus : test coverage (jococo)

With quarkus the standard [jococo](https://github.com/jacoco/jacoco) plugin has some limitations.

## quarkus-jococo

Quarkus has its own extension [quarkus-jococo](https://quarkus.io/extensions/io.quarkus/quarkus-jacoco/).

Some articles seems to point out that this is because :
* quarkus modifies some sources before building bytecode, and jococo cannot correctly map source and execution.
* this is especially true in with injection in some kind of bean (for instance @ApplicationScoped).

Read for instance : 
* [Jacoco doesn't cover a class that is an injection by constructor](https://github.com/quarkusio/quarkus/issues/32254)

On real scenario, if using standard jococo implementations and quarkus, some classes may be skipped and it may be hard to understand the reason.
In my experience with quarkus this happens when a bean is both @ApplicationScoped and has some fields with @Inject annotation.

Tested on : 
* quarkus 3.7.1
* maven 3.9.5
* java 17
* a sonar scan via maven build correctly handled all the test coverage

## quarkus and eclipse

On eclipse, using the quarkus-jococo, most test failed (eclipse 2023-12).
It is possible to include quarkus-jococo dependancy only on specific profiles : 

```
		<profile>
			<id>test</id>
			<dependencies>		
				<dependency>
					<groupId>io.quarkus</groupId>
					<artifactId>quarkus-jacoco</artifactId>
					<scope>test</scope>
				</dependency>
			</dependencies>						
		</profile>
```
