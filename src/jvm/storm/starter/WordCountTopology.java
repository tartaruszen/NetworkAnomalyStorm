/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package storm.starter;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.StormSubmitter;
import backtype.storm.generated.StormTopology;
import backtype.storm.topology.TopologyBuilder;
import backtype.storm.tuple.Fields;


public class WordCountTopology {

  public static void main(String[] args) throws Exception {

    TopologyBuilder builder = new TopologyBuilder();

    builder.setSpout("spout", new MySpout());
    builder.setBolt("split", new SplitBolt(), 8).shuffleGrouping("spout");
    //check fieldsGrouping arguments - as it is it should group all srcIP on the same machine.
    builder.setBolt("count", new WordCount(), 12).fieldsGrouping("split", new Fields("srcIP"));
    builder.setBolt("graph", new GraphBolt(), 1).shuffleGrouping("split");

    Config conf = new Config();
    conf.setDebug(true);


    if (args != null && args.length > 0) {
      conf.setNumWorkers(3);

      StormSubmitter.submitTopologyWithProgressBar(args[0], conf, builder.createTopology());
    }
    else {
      conf.setMaxTaskParallelism(3);

      StormTopology topology = builder.createTopology();

      LocalCluster cluster = new LocalCluster();
      cluster.submitTopology("word-count", conf, topology);
      Thread.sleep(5000);
      //cluster.killTopology("word-count");
      cluster.shutdown();
    }
  }
}
