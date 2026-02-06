import { defineConfig } from 'vitepress';
import mathjax3 from 'markdown-it-mathjax3'

export default defineConfig({
  markdown: {
    config: (md) => {
      md.use(mathjax3)
    }
  },

  title: "石木古月的小窝",

  themeConfig: {
    siteTitle: '石木古月',

    nav: [
      { text: '首页', link: '/' },
      { text: 'Examples', link: '/markdown-examples' }
    ],

    sidebar: [
      {
        text: 'Examples',
        items: [
          { text: 'Markdown Examples', link: '/markdown-examples' },
          { text: 'Runtime API Examples', link: '/api-examples' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/ShimuGuyue' }
    ]
  }
})
