const AWS = require('aws-sdk');

exports.handler = async (event, context) => {
    const sqs = new AWS.SQS({ region: 'eu-central-1' });  // Ändern Sie die Region nach Bedarf

    for (const record of event.Records) {
        try {
            const messageBody = JSON.parse(record.body);
            console.log('Received message:', messageBody);

            // Führen Sie hier Ihre Verarbeitungsschritte mit der Nachricht aus

            // Beispiel: Löschen der Nachricht aus der Warteschlange
            const deleteParams = {
                QueueUrl: record.eventSourceARN,
                ReceiptHandle: record.receiptHandle,
            };
            await sqs.deleteMessage(deleteParams).promise();
        } catch (error) {
            console.error('Error processing message:', error);
        }
    }

    return {
        statusCode: 200,
        body: 'Function executed successfully',
    };
};
