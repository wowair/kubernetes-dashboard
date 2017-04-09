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

module.exports = new GraphQLSchema({
  query: new GraphQLObjectType({
    name: 'Root',
    fields: {
      pods: {
        type: PodList,
        resolve: () => {
          return fetch('http://localhost:8001/api/v1/pods').then(res =>
            res.json());
        },
      },
    },
  }),
});
