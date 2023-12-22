resource "github_repository" "foo" {
  name      = "ares23"
  auto_init = true
}

resource "github_repository_file" "github_file" {
  count               = terraform.workspace != "dev" ? 0 : length(data.github_repository.repositories)
  repository          = data.github_repository.repositories[count.index].id
  branch              = "refs/heads/${var.repositories[count.index].branch_pipeline}"
  file                = ".gitignore"
  content             = "**/*.tfstate"
  commit_message      = "Create .github directory"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [
      file,
      commit_message
    ]
  }
}


resource "github_repository_file" "default_pipeline" {
  count               = terraform.workspace != "dev" ? 0 : length(data.github_repository.repositories)
  repository          = data.github_repository.repositories[count.index].id
  branch              = "refs/heads/${var.repositories[count.index].branch_pipeline}"
  file                = ".github/workflows/github-pipelines.yml"
  content             = templatefile("${path.module}/assets/github-pipelines.yml", { type = var.repositories[count.index].type })
  commit_message      = "Añade o actualiza azure-pipelines.yml via terraform ***NO_CI***"
  overwrite_on_create = false

  lifecycle {
    ignore_changes = [
      file,
      commit_message
    ]
  }
}


resource "github_repository_file" "pr_template" {
  count               = terraform.workspace != "dev" ? 0 : length(data.github_repository.repositories)
  repository          = data.github_repository.repositories[count.index].id
  branch              = "refs/heads/${var.repositories[count.index].branch_pipeline}"
  file                = ".github/pull-request-template.md"
  content             = templatefile("${path.module}/assets/pull-request-template.md", { type = var.repositories[count.index].type })
  commit_message      = "Añade o actualiza azure-pipelines.yml via terraform ***NO_CI***"
  overwrite_on_create = false

  lifecycle {
    ignore_changes = [
      file,
      commit_message
    ]
  }
}
