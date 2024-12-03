import { KafkaJS } from '@confluentinc/kafka-javascript';

class KafkaConsumer {
  kafka: KafkaJS.Kafka;
  consumer: KafkaJS.Consumer;

  constructor(brokers: string[], groupId: string) {
    this.kafka = new KafkaJS.Kafka({
      kafkaJS: {
        brokers: brokers
      }
    });
    this.consumer = this.kafka.consumer({
      kafkaJS: {
        groupId: groupId
      }
    });
  }

  async subscribe(topic: string, callBack: (message: KafkaJS.Message) => void) {
    await this.consumer.connect();
    await this.consumer.subscribe({ topic: topic });
    await this.consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        callBack(message);
      }
    });
  }
}

export default KafkaConsumer;