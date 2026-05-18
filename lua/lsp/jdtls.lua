-- ============================================================================
-- nvim-jdtls (最终无错版)
-- ============================================================================
vim.cmd([[
  packadd nvim-jdtls
]])

local jdtls = require("jdtls")
local home = os.getenv("USERPROFILE")
local mason_path = home .. "/AppData/Local/nvim-data/mason/packages/jdtls/"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        local project_root = jdtls.setup.find_root({ ".git", "pom.xml", "build.gradle", "mvnw", "gradlew" })
        local workspace_dir = project_root .. "/.jdtls-workspace"
        vim.fn.mkdir(workspace_dir, "p")

        local config = {
            cmd = {
                mason_path .. "jdtls.bat",
                "-Xmx1G",
                "-javaagent:" .. mason_path .. "lombok.jar",
            },
            root_dir = project_root,
            settings = {
                java = {
                    home = os.getenv("JAVA_HOME"),
                    maven = {
                        userSettings = "D:/Apache/apache-maven-3.9.11/conf/settings.xml",
                        downloadSources = true
                    },
                    eclipse = { downloadSources = true },
                    implementationsCodeLens = { enabled = true },
                    referencesCodeLens = { enabled = true },
                    format = { enabled = true },
                }
            },
            init_options = { bundles = {} },
        }

        jdtls.start_or_attach(config)
    end
})