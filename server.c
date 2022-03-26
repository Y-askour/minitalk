/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yaskour <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/03/17 17:01:32 by yaskour           #+#    #+#             */
/*   Updated: 2022/03/24 18:14:10 by yaskour          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include "libft/libft.h"

void	handle_sig(int sig, siginfo_t *info, void *test)
{
	static char		printed;
	static int		shifter;
	static pid_t	client_pid;

	if (client_pid == 0 || info->si_pid != client_pid)
	{
		printed = 0b11111111;
		shifter = 0;
		client_pid = info->si_pid;
	}
	if (sig == SIGUSR1)
		printed = printed | 128 >> shifter;
	else
		printed = printed ^ 128 >> shifter;
	shifter++;
	if (shifter == 8)
	{
		write(1, &printed, 1);
		shifter = 0;
		printed = 0b11111111;
	}
}

int	main(void)
{
	pid_t				pid;
	struct sigaction	sa;

	pid = getpid();
	if (pid < 0)
		return (0);
	sa.sa_sigaction = &handle_sig;
	sa.sa_flags = SA_SIGINFO;
	ft_putnbr_fd(pid, 1);
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause();
	return (0);
}
