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
    securityContext: {
      type: PodItemSpecSecurityContext,
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
      type: new GraphQLList(PodItemStatusContainerStatuse),
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
          fetch();
        },
      },
    },
  }),
});
