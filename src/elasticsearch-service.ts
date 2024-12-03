import { Client } from '@elastic/elasticsearch';

class ElasticsearchService {
  client: Client;

  constructor(node: string, auth: { apiKey: string }) {
    this.client = new Client({
      node,
      auth
    });
  }

  async indexDocument(index: string, id: string, body: any) {
    return await this.client.index({ index, id, body });
  }

  async updateDocument(index: string, id: string, body: any) {
    return await this.client.update({ index, id, doc: body });
  }
}

export default ElasticsearchService;
