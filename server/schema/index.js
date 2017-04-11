const {
  GraphQLBoolean,
  GraphQLInt,
  GraphQLList,
  GraphQLObjectType,
  GraphQLSchema,
  GraphQLString,
} = require('graphql');

const fetch = require('node-fetch');

const PodItemMetadata = new GraphQLObjectType({
  name: 'PodItemMetadata',
  fields: {
    creationTimestamp: {
      type: GraphQLString,
    },
    name: {
      type: GraphQLString,
    },
  },
});

const ContainerEnv = new GraphQLObjectType({
  name: 'ContainerEnv',
  fields: {
    name: {
      type: GraphQLString,
    },
    value: {
      type: GraphQLString,
    },
  },
});

const Container = new GraphQLObjectType({
  name: 'Container',
  fields: {
    name: {
      type: GraphQLString,
    },
    image: {
      type: GraphQLString,
    },
    env: {
      type: new GraphQLList(ContainerEnv),
    },
    terminationMessagePath: {
      type: GraphQLString,
    },
    imagePullPolicy: {
      type: GraphQLString,
    },
    args: {
      type: new GraphQLList(GraphQLString),
    },
  },
});

const PodItemSpec = new GraphQLObjectType({
  name: 'PodItemSpec',
  fields: {
    containers: {
      type: new GraphQLList(Container),
    },
    restartPolicy: {
      type: GraphQLString,
    },
    terminationGracePeriodSeconds: {
      type: GraphQLInt,
    },
    dnsPolicy: {
      type: GraphQLString,
    },
    nodeName: {
      type: GraphQLString,
    },
    hostNetwork: {
      type: GraphQLBoolean,
    },
  },
});

const PodItemStatusCondition = new GraphQLObjectType({
  name: 'PodItemStatusCondition',
  fields: {
    type: {
      type: GraphQLString,
    },
    status: {
      type: GraphQLString,
    },
    lastProbeTime: {
      type: GraphQLString,
    },
    lastTransitionTime: {
      type: GraphQLString,
    },
  },
});

const PodItemStatusContainerStatusStateWaitingState = new GraphQLObjectType({
  name: 'PodItemStatusContainerStatusStateWaitingState',
  fields: {
    message: {
      type: GraphQLString,
    },
    reason: {
      type: GraphQLString,
    },
  },
});

const PodItemStatusContainerStatusStateTerminatedState = new GraphQLObjectType({
  name: 'PodItemStatusContainerStatusStateTerminatedState',
  fields: {
    startedAt: {
      type: GraphQLString,
    },
    exitCode: {
      type: GraphQLInt,
    },
  },
});

const PodItemStatusContainerStatusStateRunningState = new GraphQLObjectType({
  name: 'PodItemStatusContainerStatusStateRunningState',
  fields: {
    startedAt: {
      type: GraphQLString,
    },
  },
});

const PodItemStatusContainerStatusState = new GraphQLObjectType({
  name: 'PodItemStatusContainerStatusState',
  fields: {
    running: {
      type: PodItemStatusContainerStatusStateRunningState,
    },
    terminated: {
      type: PodItemStatusContainerStatusStateTerminatedState,
    },
    waiting: {
      type: PodItemStatusContainerStatusStateWaitingState,
    },
  },
});

const PodItemStatusContainerStatus = new GraphQLObjectType({
  name: 'PodItemStatusContainerStatus',
  fields: {
    name: {
      type: GraphQLString,
    },
    state: {
      type: PodItemStatusContainerStatusState,
    },
    ready: {
      type: GraphQLBoolean,
    },
    restartCount: {
      type: GraphQLInt,
    },
    image: {
      type: GraphQLString,
    },
    imageID: {
      type: GraphQLString,
    },
    containerID: {
      type: GraphQLString,
    },
  },
});

const PodItemStatus = new GraphQLObjectType({
  name: 'PodItemStatus',
  fields: {
    phase: {
      type: GraphQLString,
    },
    conditions: {
      type: new GraphQLList(PodItemStatusCondition),
    },
    hostIP: {
      type: GraphQLString,
    },
    podIP: {
      type: GraphQLString,
    },
    startTime: {
      type: GraphQLString,
    },
    containerStatuses: {
      type: new GraphQLList(PodItemStatusContainerStatus),
    },
  },
});

const PodItem = new GraphQLObjectType({
  name: 'PodItem',
  fields: {
    metadata: {
      type: PodItemMetadata,
    },
    spec: {
      type: PodItemSpec,
    },
    status: {
      type: PodItemStatus,
    },
  },
});

const PodListMetadata = new GraphQLObjectType({
  name: 'PodListMetadata',
  fields: {
    selfLink: {
      type: GraphQLString,
    },
    resourceVersion: {
      type: GraphQLString,
    },
  },
});

const PodList = new GraphQLObjectType({
  name: 'PodList',
  fields: {
    kind: {
      type: GraphQLString,
    },
    apiVersion: {
      type: GraphQLString,
    },
    metadata: {
      type: PodListMetadata,
    },
    items: {
      type: new GraphQLList(PodItem),
    },
  },
});

const Service = new GraphQLObjectType({
  name: 'Service',
  fields: {
    name: {
      type: GraphQLString,
    },
    healthy: {
      type: GraphQLInt,
    },
    warning: {
      type: GraphQLInt,
    },
    error: {
      type: GraphQLInt,
    },
  },
});

const ServiceList = new GraphQLObjectType({
  name: 'ServiceList',
  fields: {
    services: {
      type: new GraphQLList(Service),
    },
  },
});

module.exports = new GraphQLSchema({
  query: new GraphQLObjectType({
    name: 'Root',
    fields: {
      pods: {
        type: PodList,
        resolve: () => {
          return fetch(
            'http://localhost:8001/api/v1/namespaces/default/pods'
          ).then(res => res.json());
        },
      },
      services: {
        type: ServiceList,
        resolve: () => {
          return fetch('http://localhost:8001/api/v1/namespaces/default/pods')
            .then(res => res.json())
            .then(res => {
              const servicesWithNumberOfPods = res.items.reduce(
                (accumulated, service) => {
                  const serviceName = service.spec &&
                    service.spec.containers &&
                    service.spec.containers.filter(
                      service => service.name !== 'getready'
                    )[0].name;
                  if (service.status.phase === 'Pending') {
                    if (
                      service.status.containerStatuses[0].state.waiting &&
                      (service.status.containerStatuses[
                        0
                      ].state.waiting.reason === 'RunContainerError' ||
                        service.status.containerStatuses[
                          0
                        ].state.waiting.reason === 'ImagePullBackoff')
                    ) {
                      return Object.assign(accumulated, {
                        [serviceName]: Object.assign(
                          accumulated[serviceName] || {},
                          {
                            error: accumulated[serviceName] &&
                              accumulated[serviceName].error
                              ? accumulated[serviceName].error + 1
                              : 1,
                          }
                        ),
                      });
                    }
                  }
                  if (!service.status.containerStatuses[0].ready) {
                    return Object.assign(accumulated, {
                      [serviceName]: Object.assign(
                        accumulated[serviceName] || {},
                        {
                          warning: accumulated[serviceName] &&
                            accumulated[serviceName].warning
                            ? accumulated[serviceName].warning + 1
                            : 1,
                        }
                      ),
                    });
                  }
                  return Object.assign(accumulated, {
                    [serviceName]: Object.assign(
                      accumulated[serviceName] || {},
                      {
                        healthy: accumulated[serviceName] &&
                          accumulated[serviceName].healthy
                          ? accumulated[serviceName].healthy + 1
                          : 1,
                      }
                    ),
                  });
                },
                {}
              );
              return {
                services: Object.keys(servicesWithNumberOfPods).map(key => ({
                  name: key,
                  healthy: servicesWithNumberOfPods[key].healthy || 0,
                  warning: servicesWithNumberOfPods[key].warning || 0,
                  error: servicesWithNumberOfPods[key].error || 0,
                })),
              };
            });
        },
      },
    },
  }),
});
