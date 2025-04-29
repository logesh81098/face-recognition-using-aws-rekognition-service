from flask import Flask, render_template, request
import boto3
import io
from PIL import Image

app = Flask(__name__)

rekognition = boto3.client('rekognition', region_name='us-east-1')
dynamodb = boto3.client('dynamodb', region_name='us-east-1')

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        try:
            # Validate the uploaded file
            image_file = request.files['image_path']
            if not image_file or not image_file.filename.lower().endswith(('jpg', 'jpeg', 'png')):
                return render_template('result.html', error="Invalid file type. Please upload a valid image.")

            # Convert the image to binary
            image = Image.open(image_file)
            stream = io.BytesIO()
            image.save(stream, format="JPEG")
            image_binary = stream.getvalue()

            # Call Rekognition to search faces
            response = rekognition.search_faces_by_image(
                CollectionId='face-rekognition-collection-id',
                Image={'Bytes': image_binary}
            )

            # Handle no matches
            if 'FaceMatches' not in response or not response['FaceMatches']:
                return render_template('result.html', error="No matching faces found.")

            # Fetch matching faces from DynamoDB
            recognized_faces = []
            for match in response['FaceMatches']:
                face_id = match['Face']['FaceId']

                face = dynamodb.get_item(
                    TableName='face-prints-table',
                    Key={'RekognitionId': {'S': face_id}}
                )

                if 'Item' in face:
                    full_name = face['Item'].get('FullName', {}).get('S', 'Unknown')
                    recognized_faces.append(full_name)

            # Return the result
            if recognized_faces:
                return render_template('result.html', recognized_faces=recognized_faces)
            else:
                return render_template('result.html', error="No metadata found for recognized faces.")

        except Exception as e:
            return render_template('result.html', error=f"An error occurred: {e}")

    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=81, debug=True)