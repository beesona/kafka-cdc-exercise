import { KafkaJS } from '@confluentinc/kafka-javascript';
import KafkaConsumer from './kafka-consumer';
import ElasticSearchService from './elasticsearch-service';

const elasticSearchService = new ElasticSearchService(
  process.env.ELASTIC_URL || 'http://localhost:9200',
  {
    apiKey: process.env.ELASTIC_API_KEY || ''
  }
);
const consumer = new KafkaConsumer(
  [process.env.KAFKA_URL || 'localhost:9092'],
  process.env.KAFKA_GROUP_ID || 'user-updated'
);
consumer.subscribe(
  process.env.TOPIC_NAME || 'data.public.users',
  async (message: KafkaJS.Message) => {
    if (message.value) {
      try {
        let data = JSON.parse(message.value.toString());
        if (data.payload.op === 'u') {
          await elasticSearchService.updateDocument(
            process.env.INDEX_NAME || 'users',
            data.payload.after.id,
            data.payload.after
          );
          console.log('Document updated');
        }
      } catch (e) {
        console.error(e);
        throw e;
      }
    }
  }
);
