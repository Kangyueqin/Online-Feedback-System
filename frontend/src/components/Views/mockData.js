// mockData.js

export const mockModulesData = [
  {
    year: "2020",
    modules: [
      { code: "COMP123", name: "Introduction to Computer Science" },
      { code: "COMP456", name: "Web Development" },
      { code: "COMP789", name: "Introduction to Computer Science" },
      { code: "COMP101", name: "Web Development" },
      { code: "COMP102", name: "Web Development" },
      { code: "COMP103", name: "Web Development" },
      { code: "COMP104", name: "Web Development" },
    ],
  },
  {
    year: "2021",
    modules: [
      { code: "COMP105", name: "Data Structures and Algorithms" },
      { code: "COMP106", name: "Software Engineering" },
    ],
  },
];

export const mockAssignmentsData = {
  COMP105: [
    {
      id: 1,
      name: "Assignment 1",
      startDate: "2024-02-20",
      endDate: "2024-02-25",
    },
    {
      id: 2,
      name: "Assignment 2",
      startDate: "2024-02-25",
      endDate: "2024-04-12",
    },
    {
      id: 3,
      name: "Assignment 3",
      startDate: "2024-04-01",
      endDate: "2024-03-10",
    },
    {
      id: 4,
      name: "Assignment 4",
      startDate: "2024-04-15",
      endDate: "2024-06-15",
    },
    { id: 5, name: "Assignment 5", startDate: null, endDate: null },
    // 其他作业数据...
  ],
  // 其他模块的作业数据...
  COMP101: [
    {
      id: 6,
      name: "Assignment 1",
      startDate: "2024-02-20",
      endDate: "2024-02-25",
    },
    {
      id: 7,
      name: "Assignment 2",
      startDate: "2024-02-25",
      endDate: "2024-04-12",
    },
  ],
};

export const mockAssignmentResults = [
  {
    rubric: "Submission, Setup and Error-freeness",
    mark: 5,
    value: 10,
    comment: "",
  },
  {
    rubric: "Code layout, commenting, and quality of code",
    mark: 21,
    value: 25,
    comment:
      "You need more comments and you need to provide references for the sources you have used",
  },
  {
    rubric: "Creating web page with results",
    mark: 33,
    value: 33,
    comment: "comment 3",
  },
];
export const mockRubricsData = [
  {
    id: 1,
    rubric: "System accessible and executable",
    criteria: [
      {
        id: 1,
        criterion: "Access rights should not be too liberal ",
        value: 5,
        auto_comments: [
          {
            id: 1,
            content: "doesn't work",
            lower_bound: 0,
            upper_bound: 3,
          },
          {
            id: 2,
            content: "works but wrong name and world readable",
            lower_bound: 3,
            upper_bound: 3,
          },
          {
            id: 3,
            content: "wrong name and correct rights",
            lower_bound: 4,
            upper_bound: 4,
          },
          {
            id: 4,
            content: "correct name but world readable",
            lower_bound: 5,
            upper_bound: 5,
          },
        ],
      },
    ],
  },
  {
    id: 2,
    rubric: "Input handling",
    criteria: [
      {
        id: 2,
        criterion: "Web page with two text fields and a submit button",
        value: 2,
        auto_comments: [
          {
            id: 5,
            content: "without two text fields or submit button",
            lower_bound: 0,
            upper_bound: 2,
          },
        ],
      },
      {
        id: 3,
        criterion:
          "CGI.pm is used (3 x 2 marks), plain HTML is used (3 x 1 mark)",
        value: 8,
        auto_comments: [
          {
            id: 6,
            content: "lack of CGI.pm or plain HTML",
            lower_bound: 0,
            upper_bound: 8,
          },
        ],
      },
    ],
  },
];

export const mockCommentsData = {
  // 根据rubrics的id分割comments
  1: [
    {
      id: 1,
      content: "doesn't work",
      lower_bound: 0,
      upper_bound: 3,
    },
    {
      id: 2,
      content: "works but wrong name and world readable",
      lower_bound: 3,
      upper_bound: 3,
    },
    {
      id: 3,
      content: "wrong name and correct rights",
      lower_bound: 4,
      upper_bound: 4,
    },
    {
      id: 4,
      content: "correct name but world readable",
      lower_bound: 5,
      upper_bound: 5,
    },
  ],
  2: [
    {
      id: 5,
      content: "without two text fields or submit button",
      lower_bound: 0,
      upper_bound: 2,
    },
    {
      id: 6,
      content: "lack of CGI.pm or plain HTML",
      lower_bound: 0,
      upper_bound: 8,
    },
  ],
};