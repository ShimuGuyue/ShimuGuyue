import { defineConfig } from 'vitepress';
import { generateSidebar } from 'vitepress-sidebar'
import mathjax3 from 'markdown-it-mathjax3'

export default defineConfig({
  // markdown 依赖
  markdown: {
    config: (md) => {
      md.use(mathjax3)
    }
  },

  title: "石木古月的小窝",

  themeConfig: {
    siteTitle: '石木古月',

    // 导航栏
    nav: [
      { text: '首页', link: '/' },
      { text: '学习笔记', items: [
          { text: '算法和数据结构', link: '/学习笔记/算法和数据结构/' }
        ]
      },
      { text: 'Examples', link: '/markdown-examples' }
    ],

    // 侧边栏
    sidebar: generateSidebar({
      documentRootPath: 'docs',
      scanStartPath: '/学习笔记/算法和数据结构/',
      rootGroupText: '算法和数据结构',
      collapsed: true,
    }),

    // 上下页链接
    docFooter: {
      prev: false,
      next: false
    },

    // 社交链接
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ShimuGuyue' }
    ],

    // 版权信息
    footer: {
      message: '本项目基于 CC0-1.0 协议开源',
      copyright: '© 2026 胡岩松 版权所有'
    }
  }
})
