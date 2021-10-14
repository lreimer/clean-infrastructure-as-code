import * as awsx from "@pulumi/awsx";

// Build and publish the image to ECR
const repo = new awsx.ecr.Repository("nginx-pulumi");
const nginxImage = repo.buildAndPushImage("./app");

// Create a load balancer to listen for requests and route them to the container.
let lb = new awsx.lb.NetworkListener("nginx", { port: 80 });

// Define the service, building and publishing our "./app/Dockerfile", and using the load balancer.
let service = new awsx.ecs.FargateService("nginx", {
    taskDefinitionArgs: {
        containers: {
            nginx: {
                // alternatively, if we do not need the image and ECR
                image: awsx.ecr.buildAndPushImage("app", "./app").image(),
                memory: 512,
                portMappings: [ lb ],
            },
        },
    },
    desiredCount: 2,
});

// Export the URL so we can easily access it.
export const url = lb.endpoint.hostname;
