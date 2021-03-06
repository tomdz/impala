# Copyright 2012 Cloudera Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


cmake_minimum_required(VERSION 2.6)

# where to put generated libraries
set(LIBRARY_OUTPUT_PATH "${BUILD_OUTPUT_ROOT_DIRECTORY}/exec")

# where to put generated binaries
set(EXECUTABLE_OUTPUT_PATH "${BUILD_OUTPUT_ROOT_DIRECTORY}/exec")

add_library(Exec STATIC
  aggregation-node.cc
  aggregation-node-ir.cc
  buffered-byte-stream.cc
  data-sink.cc
  ddl-executor.cc
  delimited-text-parser.cc
  exec-node.cc
  exchange-node.cc
  hash-join-node.cc
  hash-join-node-ir.cc
  hash-table.cc
  hdfs-byte-stream.cc
  hdfs-scan-node.cc
  hdfs-scanner.cc
  hdfs-scanner-ir.cc
  hdfs-table-sink.cc
  hdfs-table-writer.cc
  hdfs-rcfile-scanner.cc
  hdfs-sequence-scanner.cc
  hdfs-text-scanner.cc
  hdfs-lzo-text-scanner.cc
  hdfs-text-table-writer.cc
  merge-node.cc
  hdfs-trevni-scanner.cc
  hdfs-trevni-table-writer.cc
  hbase-scan-node.cc
  hbase-table-scanner.cc
  read-write-util.cc
  scan-range-context.cc
  serde-utils.cc
  scan-node.cc
  text-converter.cc
  topn-node.cc
)

target_link_libraries(Exec
  Runtime
  ${JAVA_JVM_LIBRARY}
  ${HDFS_LIBS}
)

#add_executable(sequence-file-recovery-test sequence-file-recovery-test.cc)
#target_link_libraries(sequence-file-recovery-test ${IMPALA_TEST_LINK_LIBS})
#add_test(sequence-file-recovery-test ${BUILD_OUTPUT_ROOT_DIRECTORY}/exec/sequence-file-recovery-test)

add_executable(zigzag-test zigzag-test.cc)
target_link_libraries(zigzag-test ${IMPALA_TEST_LINK_LIBS})
add_test(zigzag-test ${BUILD_OUTPUT_ROOT_DIRECTORY}/exec/zigzag-test)

add_executable(hash-table-test hash-table-test.cc)
target_link_libraries(hash-table-test ${IMPALA_TEST_LINK_LIBS})
add_test(hash-table-test ${BUILD_OUTPUT_ROOT_DIRECTORY}/exec/hash-table-test)

add_executable(delimited-text-parser-test delimited-text-parser-test.cc)
target_link_libraries(delimited-text-parser-test ${IMPALA_TEST_LINK_LIBS})
add_test(delimited-text-parser-test ${BUILD_OUTPUT_ROOT_DIRECTORY}/exec/delimited-text-parser-test)
