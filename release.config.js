module.exports = {
    plugins: [
        '@semantic-release/commit-analyzer',
        '@semantic-release/release-notes-generator',
        '@semantic-release/changelog',
        /*
         * [
         *     '@semantic-release/npm',
         *     { pkgRoot: './.publish' },
         * ],
         * [
         *     '@semantic-release/npm',
         *     { npmPublish: false },
         * ],
         */
        '@semantic-release/github',
    ],
    branches: ['master'],
    repositoryUrl: 'https://github.com/IBelyaev/core-components-test',
};
