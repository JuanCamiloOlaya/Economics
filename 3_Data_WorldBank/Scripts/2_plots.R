# Plot 1 ------------------------------------------------------------------
p1 <- ggplot(data, aes(year, GDP, group = country, colour = country)) +
  geom_line(aes(linetype = country), size = 1) +
  geom_point(aes(shape = country), size = 1) +
  xlab('Years') +
  ylab('annual %') +
  ggtitle('Evolution of GDP growth') +
  labs(color = "", group = NULL) +
  theme(legend.position = c(0.8, 1.08),
        axis.text.x = element_text(angle = 90, vjust = 0.5, size = 12),
        axis.text.y = element_text(angle = 90, vjust = 0.5, size = 12),
        panel.grid.minor = element_blank(),
        legend.text = element_text(size = 14)
  ) + 
  scale_x_continuous(breaks = seq(1960, 2020, by = 5))


# Plot 2 ------------------------------------------------------------------
p2 <- ggplot(data, aes(year, GDPpc, group = country, color = country)) +
  geom_line(aes(linetype = country), size = 1) +
  geom_point(aes(shape = country), size = 1) +
  xlab('Years') +
  ylab('annual %') +
  ggtitle('Evolution of GDP per capita growth') +
  labs(color = "", group = NULL) +
  theme(legend.position = c(0.9, 1.08),
        axis.text.x = element_text(angle = 90, vjust = 0.5, size = 14),
        axis.text.y = element_text(angle = 90, vjust = 0.5, size = 14),
        panel.grid.minor = element_blank(),
        legend.text = element_text(size = 10)
  ) + 
  scale_x_continuous(breaks = seq(1960, 2020, by = 5))
