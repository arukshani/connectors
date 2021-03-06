import org.wso2.ballerina.connectors.medium;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function printJsonResponse(message mediumResponse) (string) {

    json mediumJSONResponse;
    mediumJSONResponse = messages:getJsonPayload(mediumResponse);
    system:println(jsons:toString(mediumJSONResponse));
}

function runGETSamples(medium:ClientConnector mediumConnector, string publicationId, string userId) (string) {

    message mediumResponse;

    system:println("---------------");
    system:println("  GET actions");
    system:println("---------------");
    system:println(" ");

    system:println(" ");
    system:println("Get Profile Info");
    mediumResponse = medium:ClientConnector.getProfileInfo(mediumConnector);
    printJsonResponse(mediumResponse);
    system:println(" ");

    system:println("Get Contributors of a Publication");
    mediumResponse = medium:ClientConnector.getContributors(mediumConnector, publicationId);
    printJsonResponse(mediumResponse);
    system:println(" ");

    system:println("Get List of Publications");
    mediumResponse = medium:ClientConnector.getPublications(mediumConnector, userId);
    printJsonResponse(mediumResponse);
    system:println(" ");
}

function runPOSTSamples(medium:ClientConnector mediumConnector, string publicationId, string userId) (string) {

    message mediumResponse;
    json fullJsonPayload;

    fullJsonPayload = `{"title": "Sample Payload","contentFormat": "html","content": "<h1>Sample Payload</h1><p>This is a sample payload</p>","canonicalUrl": "http://wso2.com","tags": ["sample", "test"],"publishStatus": "public"}`;

    system:println(" ");
    system:println("----------------");
    system:println("  POST actions");
    system:println("----------------");
    system:println(" ");

    system:println("Post in Profile");
    mediumResponse = medium:ClientConnector.createProfilePost(mediumConnector, userId, fullJsonPayload);
    printJsonResponse(mediumResponse);
    system:println(" ");

    system:println("Post in publication");
    mediumResponse = medium:ClientConnector.createPublicationPost(mediumConnector, publicationId, fullJsonPayload);
    printJsonResponse(mediumResponse);
    system:println(" ");
}

function main (string[] args) {

    medium:ClientConnector mediumConnector;
    string userId;
    string publicationId;
    message mediumResponse;
    json fullJsonPayload;

    if (args[0]=="get") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        publicationId = args[6];
        runGETSamples(mediumConnector, publicationId, userId);

    } else if (args[0]=="post") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        publicationId = args[6];
        runPOSTSamples(mediumConnector, publicationId, userId);

    } else if (args[0]=="getProfileInfo") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        mediumResponse = medium:ClientConnector.getProfileInfo(mediumConnector);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="getContributors") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        publicationId = args[5];
        mediumResponse = medium:ClientConnector.getContributors(mediumConnector, publicationId);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="getPublications") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        mediumResponse = medium:ClientConnector.getPublications(mediumConnector, userId);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="createProfilePost") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        userId = args[5];
        fullJsonPayload = `{"title": "Sample Payload","contentFormat": "html","content": "<h1>Sample Payload</h1><p>This is a sample payload</p>","canonicalUrl": "http://wso2.com","tags": ["sample", "test"],"publishStatus": "public"}`;
        mediumResponse = medium:ClientConnector.createProfilePost(mediumConnector, userId, fullJsonPayload);
        printJsonResponse(mediumResponse);

    } else if (args[0]=="createPublicationPost") {
        mediumConnector = create medium:ClientConnector(args[1], args[2], args[3], args[4]);
        publicationId = args[5];
        fullJsonPayload = `{"title": "Sample Payload","contentFormat": "html","content": "<h1>Sample Payload</h1><p>This is a sample payload</p>","canonicalUrl": "http://wso2.com","tags": ["sample", "test"],"publishStatus": "public"}`;
        mediumResponse = medium:ClientConnector.createPublicationPost(mediumConnector, publicationId, fullJsonPayload);
        printJsonResponse(mediumResponse);

    } else {
        mediumConnector = create medium:ClientConnector(args[0], args[1], args[2], args[3]);
        userId = args[4];
        publicationId = args[5];
        runGETSamples(mediumConnector, publicationId, userId);
        runPOSTSamples(mediumConnector, publicationId, userId);
    }

}
