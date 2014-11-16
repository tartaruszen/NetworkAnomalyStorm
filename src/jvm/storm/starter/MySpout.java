package storm.starter;

import backtype.storm.spout.SpoutOutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichSpout;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Values;
import backtype.storm.utils.Utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.Map;

/**
 * Created by fil on 08/11/14.
 */
public class MySpout extends BaseRichSpout
{
    SpoutOutputCollector _collector;
    TopologyContext _context;
    Socket sock;
    BufferedReader reader;

    @Override
    public void declareOutputFields(OutputFieldsDeclarer declarer) {
        declarer.declare(new Fields("line"));
    }

    @Override
    public void open(Map conf, TopologyContext context, SpoutOutputCollector collector) {
        _collector = collector;
        _context = context;

        try{
            sock = new Socket("Wintermute", 9999);
            reader = new BufferedReader(new InputStreamReader(sock.getInputStream()));
        }
        catch(Exception ex)
        {}

    }

    @Override
    public void nextTuple() {
        Utils.sleep(50);
        try {
            String str;
            while ((str = reader.readLine()) != null) {
                if(str.startsWith("FLOW")) {
                    this._collector.emit(new Values(str));
                }
            }
        }
        catch (Exception ex){}
    }

    /*@Override
    public void close()
    {

    }*/



}
