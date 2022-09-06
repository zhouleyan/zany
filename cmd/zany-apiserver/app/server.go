package app

import (
	"fmt"
	"github.com/spf13/cobra"
	"k8s.io/klog/v2"
	"zly.io/zany/pkg/signal"
	"zly.io/zany/pkg/version"
)

func NewAPIServerCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use: "zany-apiserver",
		Long: `The Zany API server validates and configures data
for the api objects. The API Server services REST operations.`,
		// stop printing usage when the command errors
		SilenceUsage: true,
		RunE: func(cmd *cobra.Command, args []string) error {
			return Run(signal.SetupSignalHandler())
		},
		Args: func(cmd *cobra.Command, args []string) error {
			for _, arg := range args {
				if len(arg) > 0 {
					return fmt.Errorf("%q does not take any arguments, got %q", cmd.CommandPath(), args)
				}
			}
			return nil
		},
	}
	return cmd
}

func Run(stopCh <-chan struct{}) error {
	klog.Infof("Version: %+v", version.Get())
	fmt.Println("Run!")
	return nil
}
