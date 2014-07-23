import mimetypes
import os
from ConfigParser import ConfigParser
from apiclient.discovery import build
from apiclient.http import MediaFileUpload
from argparse import ArgumentParser
from httplib2 import Http
from oauth2client.client import OAuth2WebServerFlow
from oauth2client.file import Storage
from oauth2client.tools import run as run_storage_flow
from pprint import pprint


APPLICATION_NAME = os.path.splitext(os.path.basename(__file__))[0]
CONFIG_FOLDER = os.path.expanduser('~/.invisibleroads')
CONFIG_NAME = 'default.cfg'
MIME_TYPE = 'application/octet-stream'
SERVICE_PACK_BY_NAME = {
    'calendar': ('https://www.googleapis.com/auth/calendar', 'v3'),
    'drive': ('https://www.googleapis.com/auth/drive', 'v2'),
}


def run(source_path, drive_service, mime_type):
    mime_type = mime_type or mimetypes.guess_type(source_path)[0] or MIME_TYPE
    body = dict(title=os.path.basename(source_path), mime_type=mime_type)
    media_body = MediaFileUpload(
        source_path, mimetype=mime_type, resumable=True)
    return drive_service.files().insert(
        body=body, media_body=media_body).execute()


def get_service_via_code(
        service_name, config_folder, client_id, client_secret):
    oauth_scope, api_version = SERVICE_PACK_BY_NAME[service_name]
    flow = OAuth2WebServerFlow(
        client_id, client_secret, oauth_scope,
        redirect_uri='urn:ietf:wg:oauth:2.0:oob')
    # Get credentials
    authorize_url = flow.step1_get_authorize_url()
    print('Go to the following link in your browser: ' + authorize_url)
    code = raw_input('Enter verification code: ').strip()
    credentials = flow.step2_exchange(code)
    # Use credentials
    return build(
        serviceName=service_name, version=api_version,
        http=credentials.authorize(Http()))


def get_service_via_storage(
        service_name, config_folder, client_id, client_secret, developer_key,
        user_email=None):
    oauth_scope, api_version = SERVICE_PACK_BY_NAME[service_name]
    flow = OAuth2WebServerFlow(
        client_id, client_secret, oauth_scope, user_agent=APPLICATION_NAME)
    # Get credentials
    storage_path = os.path.join(config_folder, user_email or 'default.json')
    storage = Storage(storage_path)
    credentials = storage.get()
    if not credentials or credentials.invalid:
        credentials = run_storage_flow(flow, storage)
    # Save credentials
    client_email = credentials.token_response['id_token']['email']
    credential_path = os.path.join(config_folder, client_email)
    open(credential_path, 'w').write(credentials.to_json())
    # Use credentials
    return build(
        serviceName=service_name, version=api_version,
        http=credentials.authorize(Http()), developerKey=developer_key)


if __name__ == '__main__':
    argument_parser = ArgumentParser()
    argument_parser.add_argument(
        'source_paths', metavar='PATH', nargs='+',
        help='file to upload')
    argument_parser.add_argument(
        '-c', '--config_folder', metavar='FOLDER', default=CONFIG_FOLDER,
        help='configuration folder, e.g. %s' % CONFIG_FOLDER)
    argument_parser.add_argument(
        '-m', '--mime_type', metavar='MIME_TYPE',
        help='mime_type override')
    arguments = argument_parser.parse_args()

    config_path = os.path.join(arguments.config_folder, CONFIG_NAME)
    config_parser = ConfigParser()
    config_parser.read(config_path)
    client_id = config_parser.get('oauth', 'client_id')
    client_secret = config_parser.get('oauth', 'client_secret')
    drive_service = get_service_via_code(
        'drive', arguments.config_folder, client_id, client_secret)

    for source_path in arguments.source_paths:
        pprint(run(source_path, drive_service, arguments.mime_type))
