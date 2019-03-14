#!/usr/bin/env R

library(ggplot2)
library(ggsci)
library(plyr)
library(stringr)

metrics_directory <- commandArgs(trailingOnly = TRUE)[1]
output_directory <- commandArgs(trailingOnly = TRUE)[2]

setwd(output_directory)


# Running Time and CPU Utilization
input_file <- paste(metrics_directory, "CPUUtilization.txt", sep = "/")
data <- read.csv(input_file, header = F, sep = "\t")

conditions_order <- rev(unique(data$V1))
count_element <- factor(data$V1, levels = conditions_order)
count_data <- count(count_element)

chart_runtime <- ggplot(count_data, aes(x = x, y = freq, fill = rev(factor(x)))) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = freq), hjust = 1.5, colour = "white") +
    scale_x_discrete(labels = str_wrap(conditions_order, width = 30)) +
    labs(x = "", y = "Elapsed Time (minutes)", fill = "") +
    theme(legend.position = 'none', axis.text.y = element_text(size = 11)) +
    coord_flip()

output_file <- paste(output_directory, "running_time.png", sep = "/")
ggsave(file = output_file, chart_runtime)

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels = conditions_order)

chart_cpu <- ggplot(data, aes(x = data[,2], y = data[,4])) +
    geom_line(aes(colour = factor(data[,1]))) +
    scale_y_continuous(breaks = seq(0,100,by = 6.25),limits = c(0,100)) +
    labs(x = "Elapsed Time (minutes)", y = "CPU Utilization (%)", colour = "") +
    theme(legend.justification = c(1.01,1.01), legend.position = c(1,1), legend.title = element_blank())

output_file <- paste(output_directory, "cpu_utilization.png", sep = "/")
ggsave(file = output_file, chart_cpu)


# Memory Utilization
input_file <- paste(metrics_directory, "MemoryUtilization.txt", sep = "/")
data <- read.csv(input_file, header = F, sep = "\t")

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels = conditions_order)

chart_memory <- ggplot(data, aes(x = data[,2], y = data[,4])) +
    geom_line(aes(colour = factor(data[,1]))) +
    scale_y_continuous(breaks = seq(0,100,by = 10), limits = c(0, 100)) +
    labs(x = "Elapsed Time (minutes)", y = "Memory Utilization (%)", colour = "") +
    theme(legend.justification = c(1.01,1.01), legend.position = c(1,1), legend.title = element_blank())

output_file <- paste(output_directory, "memory_utilization.png", sep = "/")
ggsave(file = output_file, chart_memory)


# Data Storage Utilization
input_file <- paste(metrics_directory, "DataStorageUtilization.txt", sep = "/")
data <- read.csv(input_file, header = F, sep = "\t")

conditions_order <- unique(data$V1)
data$V1 <- factor(data$V1, levels = conditions_order)

chart_storage <- ggplot(data, aes(x = data[,2], y = data[,4])) +
    geom_line(aes(colour = factor(data[, 1]))) +
    scale_y_continuous(breaks=seq(0,100,by = 10),limits = c(0,100)) +
    labs(x = "Elapsed Time (minutes)", y = "Data Storage Utilization (%)", colour = "") +
    theme(legend.justification = c(1.01,1.01), legend.position = c(1,1), legend.title = element_blank())

output_file <- paste(output_directory, "disk_storage_usage.png", sep = "/")
ggsave(file = output_file, chart_storage)
