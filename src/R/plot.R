#!/usr/bin/env R

library(ggplot2)
library(ggsci)
library(plyr)

metrics_directory <- commandArgs(trailingOnly = TRUE)[1]
output_directory <- commandArgs(trailingOnly = TRUE)[2]

setwd(output_directory)


# Running Time and CPU Utilization
input_file <- paste(metrics_directory, "CPUUtilization.txt", sep = "/")
data <- read.csv(input_file, header = F, sep = "\t")

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels=rev(conditions_order))

count_data <- count(data, "V1")

chart_runtime <- ggplot(count_data, aes(x = V1, y = freq, fill = factor(V1))) +
    geom_bar(stat = "identity") +
    scale_fill_nejm() +
    labs(x = "", y = "Index (minute)", fill = "Condition") +
    theme(legend.position = 'none') +
    coord_flip()

output_file <- paste(output_directory, "running_time.png", sep = "/")
ggsave(file = output_file, chart_runtime)

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels=conditions_order)

chart_cpu <- ggplot(data, aes(x = data[,2], y = data[,4])) +
    geom_line(aes(color = factor(data[,1]))) +
    ylim(0,100) +
    labs(x = "Index (minute)", y = "CPU Utilization (%)", color = "Condition")

output_file <- paste(output_directory, "cpu_utilization.png", sep = "/")
ggsave(file = output_file, chart_cpu)


# Memory Utilization
input_file <- paste(metrics_directory, "MemoryUtilization.txt", sep = "/")
data <- read.csv(input_file, header = F, sep = "\t")

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels=conditions_order)

chart_memory <- ggplot(data, aes(x = data[,2], y = data[,4])) +
    geom_line(aes(color = factor(data[,1]))) +
    ylim(0,100) +
    labs(x = "Index (minute)", y = "Memory Utilization (%)", color = "Condition")

output_file <- paste(output_directory, "memory_utilization.png", sep = "/")
ggsave(file = output_file, chart_memory)


# Data Storage Utilization
input_file <- paste(metrics_directory, "DataStorageUtilization.txt", sep = "/")
data <- read.csv(input_file, header = F, sep = "\t")

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels=conditions_order)

chart_storage <- ggplot(data, aes(x = data[,2], y = data[,4])) +
    geom_line(aes(color = factor(data[,1]))) +
    ylim(0,100) +
    labs(x = "Index (minute)", y = "Data Storage Usage (%)", color = "Condition")

output_file <- paste(output_directory, "disk_storage_usage.png", sep = "/")
ggsave(file = output_file, chart_storage)
