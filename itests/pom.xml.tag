<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Licensed to the Apache Software Foundation (ASF) under one or more
  ~ contributor license agreements.  See the NOTICE file distributed with
  ~ this work for additional information regarding copyright ownership.
  ~ The ASF licenses this file to You under the Apache License, Version 2.0
  ~ (the "License"); you may not use this file except in compliance with
  ~ the License.  You may obtain a copy of the License at
  ~
  ~      http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.apache.unomi</groupId>
        <artifactId>unomi-root</artifactId>
        <version>1.4.1-jahia</version>
    </parent>
    <artifactId>unomi-itests</artifactId>
    <name>Apache Unomi :: Integration Tests</name>
    <description>Apache Unomi Context Server integration tests</description>

    <dependencies>
        <dependency>
            <groupId>org.apache.unomi</groupId>
            <artifactId>jcustomer</artifactId>
            <version>${project.version}</version>
            <type>tar.gz</type>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.unomi</groupId>
            <artifactId>unomi-router-karaf-feature</artifactId>
            <classifier>features</classifier>
            <version>${project.version}</version>
            <type>xml</type>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.unomi</groupId>
            <artifactId>unomi-persistence-spi</artifactId>
            <version>${project.version}</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.unomi</groupId>
            <artifactId>unomi-wab</artifactId>
            <version>${project.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.unomi</groupId>
            <artifactId>unomi-lifecycle-watcher</artifactId>
            <version>${project.version}</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.httpcomponents</groupId>
            <artifactId>httpclient-osgi</artifactId>
            <type>bundle</type>
        </dependency>
        <dependency>
            <groupId>org.apache.httpcomponents</groupId>
            <artifactId>httpcore-osgi</artifactId>
        </dependency>

        <!-- Dependencies for pax exam karaf container -->
        <dependency>
            <groupId>org.ops4j.pax.exam</groupId>
            <artifactId>pax-exam-container-karaf</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.ops4j.pax.exam</groupId>
            <artifactId>pax-exam-junit4</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.ops4j.pax.exam</groupId>
            <artifactId>pax-exam</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.ops4j.pax.url</groupId>
            <artifactId>pax-url-aether</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>javax.inject</groupId>
            <artifactId>javax.inject</artifactId>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.osgi</groupId>
            <artifactId>org.osgi.core</artifactId>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-simple</artifactId>
            <version>1.6.6</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.ops4j.pax.url</groupId>
            <artifactId>pax-url-wrap</artifactId>
            <classifier>uber</classifier>
            <version>2.5.4</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- Needed if you use versionAsInProject() -->
            <plugin>
                <groupId>org.apache.servicemix.tooling</groupId>
                <artifactId>depends-maven-plugin</artifactId>
                <executions>
                    <execution>
                        <id>generate-depends-file</id>
                        <goals>
                            <goal>generate-depends-file</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>com.github.alexcojocaru</groupId>
                <artifactId>elasticsearch-maven-plugin</artifactId>
                <!-- REPLACE THE FOLLOWING WITH THE PLUGIN VERSION YOU NEED -->
                <version>6.13</version>
                <configuration>
                    <clusterName>contextElasticSearchITests</clusterName>
                    <transportPort>9500</transportPort>
                    <httpPort>9400</httpPort>
                    <version>${elasticsearch.version}</version>
                    <autoCreateIndex>true</autoCreateIndex>
                    <timeout>120</timeout>
                </configuration>
                <executions>
                    <!--
                        The elasticsearch maven plugin goals are by default bound to the
                        pre-integration-test and post-integration-test phases
                    -->
                    <execution>
                        <id>start-elasticsearch</id>
                        <phase>pre-integration-test</phase>
                        <goals>
                            <goal>runforked</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>stop-elasticsearch</id>
                        <phase>post-integration-test</phase>
                        <goals>
                            <goal>stop</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>2.20.1</version>
                <configuration>
                    <includes>
                        <include>**/*AllITs.java</include>
                    </includes>
                </configuration>
                <executions>
                    <execution>
                        <id>integration-test</id>
                        <goals>
                            <goal>integration-test</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>verify</id>
                        <goals>
                            <goal>verify</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
